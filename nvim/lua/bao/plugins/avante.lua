return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  -- version = false, -- set this if you want to always pull the latest change
  -- commit = "f9aa75459d403d9e963ef2647c9791e0dfc9e5f9",
  opts = {
    debug = false,
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    disabled_tools = { "python", "rag_search", "web_search", "fetch" },
    provider = "copilot",
    memory_summary_provider = "copilot",
    auto_suggestions_provider = "copilot",
    providers = {
      ["openai-gpt-4o-mini"] = {
        hide_in_model_selector = true,
      },
      claude = {
        hide_in_model_selector = true,
      },
      ["claude-haiku"] = {
        hide_in_model_selector = true,
      },
      ["claude-opus"] = {
        hide_in_model_selector = true,
      },
      azure = {
        hide_in_model_selector = true,
      },
      bedrock = {
        hide_in_model_selector = true,
      },
      vertex = {
        hide_in_model_selector = true,
      },
      cohere = {
        hide_in_model_selector = true,
      },
      vertex_claude = {
        hide_in_model_selector = true,
      },
      aihubmix = {
        hide_in_model_selector = true,
      },
      ["aihubmix-claude"] = {
        hide_in_model_selector = true,
      },
      openrouter_claude = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'anthropic/claude-sonnet-4',
      },
      openrouter_deepseek = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'deepseek/deepseek-r1',
      },
      openrouter_gemini_flash = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'google/gemini-2.0-flash-001',
      },
      openrouter_gemini_pro = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'google/gemini-2.5-pro',
      },
      copilot = {
        __inherited_from = "copilot",
        model = "gemini-2.5-pro",
      },
      copilot_gemini_flash = {
        __inherited_from = "copilot",
        model = "gemini-2.0-flash-001",
      },
      copilot_gemini_pro = {
        __inherited_from = "copilot",
        model = "gemini-2.5-pro",
      },
      copilot_sonnet_4 = {
        __inherited_from = "copilot",
        model = "claude-sonnet-4.5",
      },
      copilot_o4_mini = {
        __inherited_from = "copilot",
        model = "o4-mini",
      },
      gemini_pro = {
        __inherited_from = "gemini",
        model = "gemini-2.5-pro-exp-03-25",
      },
    },
    behaviour = {
      auto_suggestions = false,
      enable_token_counting = false,
      enable_cursor_planning_mode = true,
      enable_claude_text_editor_tool_mode = true,
    },
    mappings = {
      suggestion = {
        accept = "<C-Space>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      }
    },
    windows = {
      input = {
        height = 8,
      }
    },
    -- file_selector = {
    --   provider = "telescope"
    -- },
    selector = {
      provider = "telescope"
    }
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua",      -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
