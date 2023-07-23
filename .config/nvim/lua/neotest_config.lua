require('neotest').setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm run test --",
    }),
  }
})
