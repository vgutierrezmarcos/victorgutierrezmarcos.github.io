// Lógica para guardar y cargar historial de exámenes en Firebase Firestore

// Referencia a Firestore (se asume inicializado en auth.js)
// const db = firebase.firestore(); // Se debe acceder vía firebase.firestore()

// Guardar resultado del examen
async function saveExamResult(resultData) {
    const user = firebase.auth().currentUser;
    if (!user) {
        console.log('Usuario no identificado, no se guarda el resultado.');
        return;
    }

    try {
        const db = firebase.firestore();
        // Colección: users/{uid}/exam_results
        await db.collection('users').doc(user.uid).collection('exam_results').add({
            timestamp: firebase.firestore.FieldValue.serverTimestamp(),
            ...resultData
        });
        console.log('Resultado guardado en Firebase');
        showSaveSuccessMessage();
    } catch (error) {
        console.error('Error al guardar resultado:', error);
        alert('Hubo un error al guardar tu resultado en la nube.');
    }
}

// Mostrar mensaje de éxito discreto
function showSaveSuccessMessage() {
    const header = document.querySelector('.resultados-header');
    if (header) {
        const msg = document.createElement('div');
        msg.style.cssText = 'background: rgba(255,255,255,0.2); padding: 0.5rem; border-radius: 4px; margin-top: 1rem; font-size: 0.9rem;';
        msg.innerHTML = '✅ Resultado guardado en tu cuenta';
        header.appendChild(msg);
    }
}

// Cargar historial del usuario
async function loadUserHistory(uid) {
    // Esta función podría precargar datos si fuera necesario
    // Por ahora, cargamos bajo demanda cuando el usuario abre el historial
    console.log('Usuario listo para cargar historial:', uid);
}

// Mostrar UI de historial (Modal)
async function showUserHistoryUI() {
    const user = firebase.auth().currentUser;
    if (!user) {
        alert('Debes iniciar sesión para ver tu historial.');
        return;
    }

    // Crear modal si no existe (usamos el mismo estilo que profile-modal pero más ancho)
    let modal = document.getElementById('history-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'history-modal';
        modal.className = 'profile-modal'; // Reutilizamos clase base
        document.body.appendChild(modal);
    }

    // Mostrar estado de carga
    modal.style.display = 'block';
    modal.innerHTML = `
        <div class="profile-content" style="max-width: 800px; width: 95%;">
            <span class="close-profile" onclick="document.getElementById('history-modal').style.display='none'">&times;</span>
            <h3 style="color: var(--color-primary); font-family: var(--font-display); margin-bottom: 1.5rem;">📅 Tu historial de exámenes</h3>
            <div id="history-loading">Cargando datos...</div>
            <div id="history-list" style="max-height: 60vh; overflow-y: auto;"></div>
        </div>
    `;

    try {
        const db = firebase.firestore();
        const snapshot = await db.collection('users').doc(user.uid).collection('exam_results')
            .orderBy('timestamp', 'desc')
            .limit(20)
            .get();

        const listContainer = document.getElementById('history-list');
        document.getElementById('history-loading').style.display = 'none';

        if (snapshot.empty) {
            listContainer.innerHTML = '<p>Aún no has realizado ningún examen registrado.</p>';
            return;
        }

        let html = `
            <table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 0.9rem;">
                <thead>
                    <tr style="background: var(--color-bg-light); border-bottom: 2px solid var(--color-border);">
                        <th style="padding: 0.8rem;">Fecha</th>
                        <th style="padding: 0.8rem;">Nota</th>
                        <th style="padding: 0.8rem;">Aciertos</th>
                        <th style="padding: 0.8rem;">Tiempo</th>
                    </tr>
                </thead>
                <tbody>
        `;

        snapshot.forEach(doc => {
            const data = doc.data();
            const date = data.timestamp ? data.timestamp.toDate().toLocaleDateString() + ' ' + data.timestamp.toDate().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'}) : 'Sin fecha';
            const scoreClass = data.notaSobre10 >= 5 ? '#4caf50' : '#f44336';
            
            html += `
                <tr style="border-bottom: 1px solid var(--color-border-light);">
                    <td style="padding: 0.8rem;">${date}</td>
                    <td style="padding: 0.8rem; font-weight: bold; color: ${scoreClass}">${data.notaSobre10.toFixed(2)} / 10</td>
                    <td style="padding: 0.8rem;">${data.correctas}/${data.totalPreguntas}</td>
                    <td style="padding: 0.8rem;">${formatTime(data.tiempoSeconds || 0)}</td>
                </tr>
            `;
        });

        html += '</tbody></table>';
        listContainer.innerHTML = html;

    } catch (error) {
        console.error('Error cargando historial:', error);
        document.getElementById('history-loading').innerHTML = '<p style="color: red">Error al cargar el historial.</p>';
    }
}

// Helper para formato de tiempo
function formatTime(seconds) {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m}m ${s}s`;
}
