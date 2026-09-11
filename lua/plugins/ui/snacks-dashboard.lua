-- lua/plugins/ui/snacks-dashboard.lua
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  opts = {
    dashboard = {
      enabled = true,

      preset = {
        header = [[                                               
                 #####  ######                 
                ######  ########               
              ########  ##########             
            ##########  ############           
          ############  ##############         
        ############      ##############       
      #############         #############      
    #############             #############    
   ############                 #############  
                                #############  
                              #############    
           ##               #############   ## 
         ####              #############  #### 
       ######            #############  ###### 
     ########           ############  ######## 
   ##########           ##########   ######### 
 ############           ########   ########### 
 ##########             ######   ############  
 ########                ###   ############    
 #######                 #   ############      
 #####                     #############       
 ###                     #############         
 #                       ###########           
                         #########             
                         #######               
                         #####                 
                         ###                   
                         #                     
                                               ]],

        keys = {
          {
            icon = '🗂️',
            key = 'p',
            desc = '[⇧] Projects',
            action = function()
              Snacks.picker.files {
                cwd = '~/code/',
                finder = 'files',
                args = { '--type', 'd', '--max-depth', '2', '--min-depth', '2' },
                title = 'Search Projects',
                -- preview = false,
              }
            end,
          },
          {
            icon = '📁',
            key = 'P',
            desc = 'Project Files',
            action = function()
              Snacks.picker.files {
                cwd = '~/code/',
                title = 'Search Project Files',
              }
            end,
            hidden = true,
          },
          {
            icon = '📓',
            key = 'n',
            desc = '[⇧] Notes',
            action = function()
              Snacks.picker.files {
                cwd = '~/notes/',
                finder = 'files',
                args = { '--type', 'd' },
                title = 'Search Note Directories',
                -- preview = false,
              }
            end,
          },
          {
            icon = '📄',
            key = 'N',
            desc = 'Note Files',
            action = function()
              Snacks.picker.files {
                cwd = '~/notes/',
                title = 'Search Note Files',
              }
            end,
            hidden = true,
          },
          {
            icon = '💾',
            key = 's',
            desc = '[⇧] Sessions',
            action = function()
              require('mini.sessions').read()
            end,
          },
          {
            icon = '📂',
            key = 'S',
            desc = 'Pick Session',
            action = function()
              require('mini.sessions').select()
            end,
            hidden = true,
          },
          {
            icon = '📝',
            key = 'e',
            desc = '[ ] New File',
            action = ':enew',
          },
          {
            icon = '🕒',
            key = 'r',
            desc = '[ ] Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = '🔍',
            key = 'f',
            desc = '[ ] Find File',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = '󰊄 ',
            key = 'g',
            desc = '[ ] Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = '[ ] Lazy',
            action = ':Lazy',
          },
          {
            icon = '⚙️',
            key = 'c',
            desc = '[ ] Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = '🚪',
            key = 'q',
            desc = '[ ] Quit',
            action = ':qa',
          },
        },
      },

      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'recent_files', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },

  config = function(_, opts)
    require('snacks').setup(opts)

    Snacks.toggle
      .option('colorcolumn', {
        name = 'Colorcolumn',
        off = '',
        on = '80',
      })
      :map '<leader>Tc'
  end,
}
