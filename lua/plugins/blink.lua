return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-j>"] = { "scroll_documentation_down" },
      ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      trigger = {
        show_on_trigger_character = true,
      },
      menu = {
        border = "rounded",
        draw = {
          padding = { 1, 1 },
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return (icon or ctx.kind_icon) .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl or ctx.kind_hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl or ctx.kind_hl
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 150,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = true },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    fuzzy = {
      sorts = {
        function(a, b)
          if a.label == "log" and a.source_id == "snippets" then
            return true
          end
          if b.label == "log" and b.source_id == "snippets" then
            return false
          end
        end,
        "score",
        "sort_text",
        "label",
      },
    },

    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      providers = {
        snippets = {
          opts = {
            friendly_snippets = true,
            filter_snippets = function(ft, file)
              if ft == "typescriptreact" then
                return file:match("snippets/javascript/typescript.json") ~= nil
              end
              return true
            end,
          },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
