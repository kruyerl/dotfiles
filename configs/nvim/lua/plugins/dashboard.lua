return {
  {
    "nvimdev/dashboard-nvim",
    event = 'VimEnter',
    config = function ()
      require('dashboard').setup {
        theme = 'hyper', --  theme is doom and hyper default is hyper
        disable_move = true,    --  default is false disable move keymap for hyper
        shortcut_type = "letter",   --  shorcut type 'letter' or 'number'
        shuffle_letter = true,  --  default is true, shortcut 'letter' will be randomize, set to false to have ordered letter.
        change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
        config = {
          theme = 'doom',
          config = {
            header = {}, --your header
            center = {
              {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find File           ',
                desc_hl = 'String',
                key = 'b',
                keymap = 'SPC f f',
                key_hl = 'Number',
                key_format = ' %s', -- remove default surrounding `[]`
                action = 'lua print(2)'
              },
              {
                icon = ' ',
                desc = 'Find Dotfiles',
                key = 'f',
                keymap = 'SPC f d',
                key_format = ' %s', -- remove default surrounding `[]`
                action = 'lua print(3)'
              },
            },
            footer = {}  --your footer
          }
        }
      }
    end
  }
}
