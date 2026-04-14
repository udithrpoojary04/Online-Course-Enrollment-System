// Theme Toggle — persists preference in localStorage
(function() {
    const savedTheme = localStorage.getItem('elite-academy-theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);
})();

function toggleTheme() {
    const html = document.documentElement;
    const current = html.getAttribute('data-theme') || 'dark';
    const next = current === 'dark' ? 'light' : 'dark';
    html.setAttribute('data-theme', next);
    localStorage.setItem('elite-academy-theme', next);

    // Update toggle button icon
    const btn = document.getElementById('themeToggleBtn');
    if (btn) {
        btn.textContent = next === 'dark' ? '☀️' : '🌙';
    }
}

// Set correct icon on page load
document.addEventListener('DOMContentLoaded', function() {
    const theme = document.documentElement.getAttribute('data-theme') || 'dark';
    const btn = document.getElementById('themeToggleBtn');
    if (btn) {
        btn.textContent = theme === 'dark' ? '☀️' : '🌙';
    }
});
