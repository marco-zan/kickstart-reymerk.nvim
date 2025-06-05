--
-- To highlight the color in css files. It is sooooo handy
return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      css = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
      scss ={ rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
      sass = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
      html = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
      htmldjango = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
      'javascript';
      'javascriptreact';
      'typescript';
      'typescriptreact';
      'vue';
      'svelte';
      'lua';
    }
  end,
}

