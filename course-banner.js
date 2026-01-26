/**
 * Script para manejar el banner del curso
 * El banner permanece oculto durante 10 minutos después de cerrarlo
 */

// Función para cerrar el banner
function closeCourseBanner() {
    const banner = document.getElementById('course-banner');
    if (banner) {
        banner.classList.add('hidden');
        // Guardar el timestamp de cuando se cerró
        localStorage.setItem('courseBannerClosedAt', new Date().getTime().toString());
    }
}

// Verificar si el banner debe mostrarse al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    const banner = document.getElementById('course-banner');
    const closedAt = localStorage.getItem('courseBannerClosedAt');

    if (closedAt && banner) {
        const now = new Date().getTime();
        const closedTime = parseInt(closedAt);
        const tenMinutesInMs = 10 * 60 * 1000; // 10 minutos en milisegundos

        // Si no han pasado 10 minutos, mantener el banner oculto
        if (now - closedTime < tenMinutesInMs) {
            banner.classList.add('hidden');
        } else {
            // Han pasado más de 10 minutos, limpiar el storage
            localStorage.removeItem('courseBannerClosedAt');
        }
    }
});
