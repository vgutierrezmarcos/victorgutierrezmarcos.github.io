/**
 * Script para manejar el banner del curso
 * Coloca este código en un archivo course-banner.js o al final del body
 */

// Función para cerrar el banner
function closeCourseBanner() {
    const banner = document.getElementById('course-banner');
    if (banner) {
        banner.classList.add('hidden');
    }
}

// Verificar si el banner debe mostrarse al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    const banner = document.getElementById('course-banner');
    const bannerClosed = localStorage.getItem('courseBannerClosed');
    
    // Si el usuario ya cerró el banner anteriormente, ocultarlo
    if (bannerClosed === 'true' && banner) {
        banner.classList.add('hidden');
    }
});

// OPCIONAL: Resetear el banner después de cierto tiempo (ej: 7 días)
// Descomenta este código si quieres que el banner vuelva a aparecer después de un tiempo
/*
document.addEventListener('DOMContentLoaded', function() {
    const banner = document.getElementById('course-banner');
    const bannerClosedDate = localStorage.getItem('courseBannerClosedDate');
    const now = new Date().getTime();
    const sevenDaysInMs = 7 * 24 * 60 * 60 * 1000;
    
    if (bannerClosedDate) {
        const closedDate = parseInt(bannerClosedDate);
        // Si han pasado más de 7 días, mostrar el banner de nuevo
        if (now - closedDate > sevenDaysInMs) {
            localStorage.removeItem('courseBannerClosed');
            localStorage.removeItem('courseBannerClosedDate');
            if (banner) {
                banner.classList.remove('hidden');
            }
        }
    }
});

// Modificar la función de cerrar para guardar también la fecha
function closeCourseBanner() {
    const banner = document.getElementById('course-banner');
    if (banner) {
        banner.classList.add('hidden');
        localStorage.setItem('courseBannerClosed', 'true');
        localStorage.setItem('courseBannerClosedDate', new Date().getTime().toString());
    }
}
*/
