const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    fontFamily: {
      sans: ['Virgil, sans-serif', ...defaultTheme.fontFamily.sans], // Adds a new font-display class
      nunito: ['Nunito Sans, sans-serif']
    }
  }
}
