module.exports = {
    //purge: {
    //    mode: "all",
    //    content: ["./Web/View/**/*.hs", "./assets/**/*.css"],
    //},
    darkMode: 'media', // or 'media' or 'class'
    theme: {
        extend: {},
    },
    variants: {
        extend: {},
    },
    plugins: [
        require('@tailwindcss/forms'),
    ],
};
