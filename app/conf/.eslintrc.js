module.exports = {
    "extends": "standard",
    "env": {
      "mocha": true,
      "webextensions": true,
      "jquery": true
    },
    "rules": {
        "quotes": ["off", "double"],
        "no-unused-expressions": 0,
        "no-undef": 0,
        "chai-friendly/no-unused-expressions": 2
    },
    "plugins": [
        "chai-friendly"
    ]
};
