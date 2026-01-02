local colors = {
  bg = '#16161e',
  bg_alt = '#1a1b26',
  bg_soft = '#20212c',
  fg = '#d7daf0',
  inactive = '#5f6380',

  a = { bg = '#7aa2f7', fg = '#16161e' }, -- blue mode
  b = { bg = '#f472b6', fg = '#16161e' }, -- project badge stays pink
  c = { bg = '#16161e', fg = '#d7daf0' },
  x = { bg = '#c099ff', fg = '#16161e' }, -- lilac
  y = { bg = '#f8bd96', fg = '#16161e' }, -- soft orange (NORMAL)
  z = { bg = '#f25f76', fg = '#16161e' }, -- reddish‑pink (NORMAL)

  bright = {
    normal = '#7aa2f7', -- blue
    insert = '#f78fb3', -- pink
    visual = '#c099ff', -- violet
    replace = '#f25f76', -- red
    command = '#f8bd96', -- orange
  },
}

return {
  normal = {
    a = { bg = colors.a.bg, fg = colors.a.fg, gui = 'bold' },
    b = { bg = colors.b.bg, fg = colors.a.bg, gui = 'bold' },
    c = { bg = colors.c.bg, fg = colors.c.fg },
    x = { bg = colors.x.bg, fg = colors.a.bg, gui = 'bold' },
    y = { bg = colors.y.bg, fg = colors.a.bg, gui = 'bold' },
    z = { bg = colors.z.bg, fg = colors.a.bg, gui = 'bold' },
  },

  insert = {
    a = { bg = colors.bright.insert, fg = colors.a.fg, gui = 'bold' },
    b = { bg = colors.x.bg, fg = colors.bright.insert, gui = 'bold' },
    c = { bg = colors.c.bg, fg = colors.c.fg },
    x = { bg = colors.x.bg, fg = colors.bright.insert, gui = 'bold' },
    y = { bg = '#c099ff', fg = colors.bright.insert, gui = 'bold' }, -- lilac for insert
    z = { bg = '#7aa2f7', fg = colors.bright.insert, gui = 'bold' }, -- blue for insert
  },

  visual = {
    a = { bg = colors.bright.visual, fg = colors.a.fg, gui = 'bold' },
    b = { bg = colors.z.bg, fg = colors.bright.visual, gui = 'bold' },
    c = { bg = colors.c.bg, fg = colors.c.fg },
    x = { bg = colors.x.bg, fg = colors.bright.visual, gui = 'bold' },
    y = { bg = '#f78fb3', fg = colors.bright.visual, gui = 'bold' }, -- pink for visual
    z = { bg = '#f8bd96', fg = colors.bright.visual, gui = 'bold' }, -- orange for visual
  },

  replace = {
    a = { bg = colors.bright.replace, fg = colors.a.fg, gui = 'bold' },
    b = { bg = colors.y.bg, fg = colors.bright.replace, gui = 'bold' },
    c = { bg = colors.c.bg, fg = colors.c.fg },
    x = { bg = colors.x.bg, fg = colors.bright.replace, gui = 'bold' },
    y = { bg = '#c099ff', fg = colors.bright.replace, gui = 'bold' }, -- lilac for replace
    z = { bg = '#f78fb3', fg = colors.bright.replace, gui = 'bold' }, -- pink for replace
  },

  command = {
    a = { bg = colors.bright.command, fg = colors.a.fg, gui = 'bold' },
    b = { bg = colors.a.bg, fg = colors.bright.command, gui = 'bold' },
    c = { bg = colors.c.bg, fg = colors.c.fg },
    x = { bg = colors.x.bg, fg = colors.bright.command, gui = 'bold' },
    y = { bg = '#7aa2f7', fg = colors.bright.command, gui = 'bold' }, -- blue for command
    z = { bg = '#c099ff', fg = colors.bright.command, gui = 'bold' }, -- lilac for command
  },

  inactive = {
    a = { bg = colors.bg_soft, fg = colors.inactive },
    b = { bg = colors.bg_soft, fg = colors.inactive },
    c = { bg = colors.bg_soft, fg = colors.inactive },
    x = { bg = colors.bg_soft, fg = colors.inactive },
    y = { bg = colors.bg_soft, fg = colors.inactive },
    z = { bg = colors.bg_soft, fg = colors.inactive },
  },
}
