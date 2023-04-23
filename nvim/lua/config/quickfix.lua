require("bqf").setup({
  auto_resize_height = true,
  preview = {
    auto_preview = true,
    should_preview_cb = function(bufnr, qwinid)
      print(qwinid)
      return true
    end
  }
})
