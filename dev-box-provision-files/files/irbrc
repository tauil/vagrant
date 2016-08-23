# encoding: utf-8
require "irb/completion"

IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = File.expand_path("~/.irb_history")
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
if File.file?(IRB.conf[:HISTORY_FILE])
  lines = File.readlines(IRB.conf[:HISTORY_FILE]).collect do |line|
    line.gsub(/^p */, "").chomp
  end

  Readline::HISTORY.push(*lines)
end

at_exit do
  lines = Readline::HISTORY.to_a.uniq
  lines = lines.reject {|l| %w[c exit l nil irb].include?(l) }

  count = lines.count
  start = [count - IRB.conf[:SAVE_HISTORY], 0].max
  lines = lines[start, IRB.conf[:SAVE_HISTORY]]

  File.open(IRB.conf[:HISTORY_FILE], "w+") do |file|
    file.flock(File::LOCK_EX)
    file.puts(lines)
    file.flock(File::LOCK_UN)
  end
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

prompt = "#{RUBY_VERSION}"

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I =>"#{prompt} >> ",
  :PROMPT_N =>"#{prompt} >> ",
  :PROMPT_S =>"#{prompt} >> ",
  :PROMPT_C =>"#{prompt} ?> ",
  :RETURN   =>"=> %s\n"
}

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:PROMPT_MODE] = :CUSTOM

# http://coderwall.com/p/6yqm-q?i=1&p=1&q=&t=shell
def copy(*args)
  IO.popen('pbcopy', 'r+') { |clipboard| clipboard.puts args.map(&:inspect) }
end

begin
  require 'pry'
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end
