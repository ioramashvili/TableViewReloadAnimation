Pod::Spec.new do |s|
  s.name             = 'TableViewReloadAnimation'
  s.version          = '0.0.3'
  s.summary          = 'Animate tableView cells'
 
  s.description      = <<-DESC
TableView reaload animations with lot of options
                       DESC
 
  s.homepage         = 'https://github.com/ioramashvili/TableViewReloadAnimation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shota ioramashvili' => 'shotaioramashvili@gmail.com' }
  s.source           = { :git => 'https://github.com/ioramashvili/TableViewReloadAnimation.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'TableViewReloadAnimation/UITableView+Extension.swift'
 
end
