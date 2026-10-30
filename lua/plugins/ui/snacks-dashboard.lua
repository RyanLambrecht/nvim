-- lua/plugins/ui/snacks-dashboard.lua

-- Picker that lists directories and :cd's into the selected one.
-- `extra_args` are appended to the fd args (e.g. depth limits).
local function pick_dir(cwd, title, extra_args)
  Snacks.picker.files {
    cwd = cwd,
    finder = 'files',
    args = vim.list_extend({ '--type', 'd' }, extra_args or {}),
    title = title,
    confirm = function(picker, item)
      picker:close()
      local dir = item and Snacks.picker.util.path(item)
      if dir then
        vim.cmd.cd(vim.fn.fnameescape(dir))
        vim.notify('cwd: ' .. vim.fn.getcwd(), vim.log.levels.INFO)
        -- Opens whatever handles directory buffers (oil, netrw, etc.)
        vim.schedule(function()
          vim.cmd.edit '.'
        end)
      end
    end,
  }
end

---@type LazySpec
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
              -- Limit to top-level project dirs: { '--max-depth', '2', '--min-depth', '2' }
              pick_dir('~/code/', 'Search Projects')
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
              pick_dir('~/notes/', 'Search Note Directories')
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
          -- {
          --   icon = '󰊄 ',
          --   key = 'g',
          --   desc = '[ ] Find Text',
          --   action = ":lua Snacks.dashboard.pick('live_grep')",
          -- },
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
