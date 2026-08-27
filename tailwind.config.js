/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./*.html'],
  theme: {
    extend: {
      colors: {
        obsidian: '#0B000E',
        slate: '#292E31',
        'slate-700': '#20252A',
        warmwhite: '#F5F3EE',
        steel: '#A9ADB0',
        copper: '#C46F3B',
        'copper-dark': '#A2542A',
        'copper-soft': '#D68A5A',
        safety: '#E8BB4A',
      },
      fontFamily: {
        display: ['Manrope', 'system-ui', 'sans-serif'],
        body: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['"Space Mono"', 'ui-monospace', 'monospace'],
      },
      letterSpacing: {
        tightest: '-0.035em',
      },
      boxShadow: {
        'card': '0 1px 1px rgba(11,0,14,0.04), 0 8px 18px -6px rgba(11,0,14,0.12), 0 24px 48px -20px rgba(41,46,49,0.18)',
        'card-hover': '0 2px 4px rgba(11,0,14,0.06), 0 14px 28px -8px rgba(196,111,59,0.22), 0 40px 70px -30px rgba(41,46,49,0.28)',
        'float': '0 20px 60px -18px rgba(11,0,14,0.45), 0 6px 16px -6px rgba(11,0,14,0.3)',
      },
    },
  },
  plugins: [],
};
