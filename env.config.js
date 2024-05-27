module.exports = {
    FALSE_VALUE: false,
    CORRECT_BOOL_VALUE: 'Good, false meant false.  We did not cast a boolean to a string.',
    INCORRECT_BOOL_VALUE: 'Why was a false boolean true?',
    INTEGER_VALUE: 123,
    PARAGON_THEME_URLS: {
        core: {
            urls: {
                default: 'https://cdn.jsdelivr.net/npm/@openedx/paragon@alpha/dist/core.min.css1'
            },
        },
        defaults: {
            light: 'light',
        },
        variants: {
            light: {
                urls: {
                    default: 'https://cdn.jsdelivr.net/npm/@openedx/paragon@alpha/dist/light.min.css1',
                },
            },
        },
    },
};
