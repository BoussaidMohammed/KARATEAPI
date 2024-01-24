function fn() {
  function makeString(length) {
    const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let result = "";
    const charsetLength = charset.length;
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * charsetLength);
      result += charset.charAt(randomIndex);
    }
    return result;
  }

  let config = {
    baseUrl: 'https://simple-books-api.glitch.me',
    randomString: makeString
  };
  return config;
}


