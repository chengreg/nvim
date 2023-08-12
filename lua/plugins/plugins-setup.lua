-- 自动安装packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存些文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- 自己安装的插件在这里，使用use在github地址就OK
  use 'folke/tokyonight.nvim'  -- 主题
  use {
    'nvim-lualine/lualine.nvim', -- 状态栏
    requires = { 'kyazdani42/nvim-web-devicons', opt=true } -- 状态栏图标
  }

  use {
    'nvim-tree/nvim-tree.lua', -- 文档树
    requires = { 'nvim-tree/nvim-web-devicons',} -- 文档树图标
  }
  use("christoomey/vim-tmux-navigator") -- 用ctl+hjkl来定位窗口

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
