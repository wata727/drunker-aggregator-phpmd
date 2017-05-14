require "spec_helper"

RSpec.describe Drunker::Aggregator::Phpmd do
  let(:aggregator) { Drunker::Aggregator::Phpmd.new }
  let(:layers) do
    [
      Drunker::Artifact::Layer.new(
        build_id: "project_name:build_id_1",
        stdout: <<XML,
<?xml version="1.0" encoding="UTF-8" ?>
<pmd version="@project.version@" timestamp="2017-05-14T07:22:12+00:00">
  <file name="/home/testuser/test1.php">
    <violation beginline="30" endline="30" rule="StaticAccess" ruleset="Clean Code Rules" externalInfoUrl="http://phpmd.org/rules/cleancode.html#staticaccess" priority="1">
      Avoid using static access to class '\\Composer\\Autoload\\ComposerStaticInit6afbe844dcd40a00c625dde1a02ce1f2' in method 'getLoader'.
    </violation>
    <violation beginline="31" endline="46" rule="ElseExpression" ruleset="Clean Code Rules" externalInfoUrl="http://phpmd.org/rules/cleancode.html#elseexpression" priority="1">
      The method getLoader uses an else expression. Else is never necessary and you can simplify the code to work without else.
    </violation>
    <violation beginline="52" endline="54" rule="ElseExpression" ruleset="Clean Code Rules" externalInfoUrl="http://phpmd.org/rules/cleancode.html#elseexpression" priority="1">
      The method getLoader uses an else expression. Else is never necessary and you can simplify the code to work without else.
    </violation>
  </file>
</pmd>
XML
        stderr: "warning!",
        exit_status: 0,
      ),
      Drunker::Artifact::Layer.new(
        build_id: "project_name:build_id_2",
        stdout: <<XML,
<?xml version="1.0" encoding="UTF-8" ?>
<pmd version="@project.version@" timestamp="2017-05-14T07:22:31+00:00">
  <file name="/home/testuser/test2.php">
    <violation beginline="52" endline="56" rule="StaticAccess" ruleset="Clean Code Rules" externalInfoUrl="http://phpmd.org/rules/cleancode.html#staticaccess" priority="1">
      Avoid using static access to class '\\Closure' in method 'getInitializer'.
    </violation>
  </file>
  <file name="/home/testuser/test3.php">
    <violation beginline="89" endline="91" rule="ElseExpression" ruleset="Clean Code Rules" externalInfoUrl="http://phpmd.org/rules/cleancode.html#elseexpression" priority="1">
      The method testObjectCastToString uses an else expression. Else is never necessary and you can simplify the code to work without else.
    </violation>
  </file>
</pmd>
XML
        stderr: "Failed...",
        exit_status: 1,
      )
    ]
  end

  describe "#run" do
    before { Timecop.freeze(Time.local(2017)) }
    after { Timecop.return }

    it "outputs result" do
      output =<<OUTPUT
<?xml version='1.0' encoding='UTF-8'?>
<pmd version='@project.version@' timestamp='#{Time.now.iso8601}'>
  <file name='/home/testuser/test1.php'>
    <violation beginline='30' endline='30' rule='StaticAccess' ruleset='Clean Code Rules' externalInfoUrl='http://phpmd.org/rules/cleancode.html#staticaccess' priority='1'>
       Avoid using static access to class
      '\\Composer\\Autoload\\ComposerStaticInit6afbe844dcd40a00c625dde1a02ce1f2' in
      method 'getLoader'. 
    </violation>
    <violation beginline='31' endline='46' rule='ElseExpression' ruleset='Clean Code Rules' externalInfoUrl='http://phpmd.org/rules/cleancode.html#elseexpression' priority='1'>
       The method getLoader uses an else expression. Else is never necessary and
      you can simplify the code to work without else. 
    </violation>
    <violation beginline='52' endline='54' rule='ElseExpression' ruleset='Clean Code Rules' externalInfoUrl='http://phpmd.org/rules/cleancode.html#elseexpression' priority='1'>
       The method getLoader uses an else expression. Else is never necessary and
      you can simplify the code to work without else. 
    </violation>
  </file>
  <file name='/home/testuser/test2.php'>
    <violation beginline='52' endline='56' rule='StaticAccess' ruleset='Clean Code Rules' externalInfoUrl='http://phpmd.org/rules/cleancode.html#staticaccess' priority='1'>
       Avoid using static access to class '\\Closure' in method 'getInitializer'.
      
    </violation>
  </file>
  <file name='/home/testuser/test3.php'>
    <violation beginline='89' endline='91' rule='ElseExpression' ruleset='Clean Code Rules' externalInfoUrl='http://phpmd.org/rules/cleancode.html#elseexpression' priority='1'>
       The method testObjectCastToString uses an else expression. Else is never
      necessary and you can simplify the code to work without else. 
    </violation>
  </file>
</pmd>
OUTPUT
      expect { aggregator.run(layers) }.to output(output).to_stdout
    end
  end

  describe "#exit_status" do
    it "returns 1 as exit status code" do
      expect(aggregator.exit_status(layers)).to eq 1
    end

    context "when artifact layer is invalid" do
      before { layers.each(&:invalid!) }

      it "returns 1 as exit status code" do
        expect(aggregator.exit_status(layers)).to eq 1
      end
    end
  end
end
