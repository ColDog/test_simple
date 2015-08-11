require "colorize"

class Object
  $assertions = 0
  $failed = 0
  $error = 0
  $passed = 0
  $no = 1
  $msg = {}
  $pp = {}

  def pp(to_print)
    $pp[$no] ||= []
    $pp[$no] << to_print
    $pp[$no] = $pp[$no].uniq
  end

  def setup
    yield
  end

  def should(name = 'test')
    space = 31 - name.length
    raise FormulationError, 'Test name too long must be 30 char or less' if name.length > 50
    begin
      yield
      if yield == false
        raise Fail
      end
      print "passed".colorize(:green)
      $passed += 1
    rescue Fail => e
      print "failed".colorize(:red)
      $msg["#{$no}. #{name}"] = [e]
      $failed += 1
    rescue => exception
      print "error ".colorize(:red)
      $msg["#{$no}. #{name}"] = [exception] + exception.backtrace
      $error += 1
    end
    print "  #{$no}. #{name}"
    puts ' '
    $pp[$no].each { |pp| puts pp } if $pp[$no]
    puts ' ' if $pp[$no]
    $no += 1
  end

  def assert(actual, expect)
    $assertions += 1
    raise Fail, "compared: #{actual} == #{expect}" unless actual == expect
  end

  def assert_not(actual, expect)
    $assertions += 1
    raise Fail, "compared: #{actual} == #{expect}" unless actual != expect
  end

  def results
    color = ($failed >= 1 or $error >= 1) ? :red : :green
    puts ' '
    puts "Failed: #{$failed}, Errors: #{$error}, Passed: #{$passed}, Total: #{$failed + $error + $passed}, Assertions: #{$assertions}".colorize(color)
    puts ' '
    unless $msg.empty?
      puts 'FAILURES & ERRORS'
      $msg.each do |name, msg|
        puts "#{name}".colorize(:red)
        msg.each do |er|
          puts "   #{er}"
        end
        puts ' '
      end
    end
    puts ' '
  end

  class Fail < StandardError
  end
end
