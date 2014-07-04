# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require "rubygems"
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'InvoiceScanner'
  app.device_family = :ipad

  app.pods do
    pod 'OpenCV'
  end

  app.vendor_project('vendor/OpenMotionCV', :static, cflags: '-I../Pods/Headers/OpenCV')
end
