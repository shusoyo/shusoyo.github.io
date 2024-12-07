+++
 title = "Some linux configurations" 
 date = "2022-11-02T21:49:46+08:00" 
 tags = ["linux"] 
 slug = "some linux configurations"
 description = ""
 # indent = true
+++
##### 碎碎念

这些天把  Arch linux 装回来了, gnome 43，nvidia 闭源驱动加 wayland，和这台破机器运行的 windows11 相比，linux 要流畅太多了，装机不易，耗时耗力，然而谁有没有做过无聊的事情呢? 有时候我们只是需要暂时脱离宏大叙事，感受一下个人的悲欢而已，所以写文章要先撇清和所有类型主义的关系。

[12月13日更新]()            
在咸鱼上购入一台2020款的联想小新pro13，自然也是换了linux，依然是arch。



##### grub and dual system
使用 grub 引导双系统 win11 和 arch linux， 需要安装 os-prober。                
编辑  `/etc/default/grub`。
```
# /etc/default/grub
# 找到下方内容并取消注释
GRUB_DISABLE_OS_PROBER=false
```
然后生成 grub 配置文件
```
grub-mkconfig -o /boot/grub/grub.cfg
```
在 live CD 中 chroot 进入 arch 的条件下有检测不到 win boot manager 的几率，无论是否挂载了 win efi 的分区，在遇到这种情况的时候重启再操作一遍就可以了。

##### wayland and nvidia close source driver
这台破机器在 x11 的 gnome 下打字延迟很严重，所以切换到了 wayland，为了性能也需要安装 nvidia 闭源驱动，所以列出在这种情况下开启 wayland 的方法。

检查 nvidia 驱动版本是否大于 490 

```
# Add the kernel parameter 
# /etc/default/grub
# 在 GRUB_CMDLINE_LINUX_DEFAULT=" " 里添加如下内容
nvidia-drm.modeset=1
```

重启查看 gnome 设置-关于界面，如果还是 x11 那么直接执行下面命令屏蔽 udev 检测。
```
sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rules
```

[12月13日更新]()     
笔记本没有独立显卡，核心显卡驱动开源且以被整合进内核当中，原生支持wayland。
##### Fish shell
采用了影响较小的方法去启用 fish shell 而不是去改变默认shell

```
~/.bashrc     # 在 .bashrc 文件内添加 fish 指令，即在启动终端模拟器时会默认执行一次 fish

fish
````

##### Pipewire及wayland下的屏幕录制问题

安装 pipewire-media-session 即可

```
 sudo pacman -S pipewire-media-session
```
##### Paru - a aur helper
请编译 (makepkg) 安装。

##### Helix - a post-morden editor
Helix 是一款由 Rust 编写的开箱即用的类 vim + kakoune 的..后现代..[^1]编辑器。
在 archlinux 社区源里面已经有打包好的安装包，直接用包管理器安装即可，不用编译所有的语法树，但是命令会从 hx 变为 helix。

```
whereis helix
```          

找到 helix 二进制文件的路径，重命名即可。

##### 解决 grub 字体过小的问题

安装 grub-customizer

```
 paru -S grub-customizer
```
在 gui 界面中调整字体大小即可 



[^1]: 至少官网是这么说的。