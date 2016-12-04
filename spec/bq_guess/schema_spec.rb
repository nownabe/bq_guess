# frozen_string_literal: true

require "bq_guess/schema"

describe BqGuess::Schema do
  let(:instance) { described_class[initial_schema] }

  describe "#merge!" do
    subject { instance.tap { |s| s.merge!(other) }.to_a }
    let(:other) { described_class[other_schema] }

    context "when merged null field" do
      let(:initial_schema) { { "f" => BqGuess::Fields::String.new("f") } }
      let(:other_schema) { {} }
      let(:expected_schema) { [{ name: "f", type: :string, mode: :nullable }] }
      it { is_expected.to eq expected_schema }
    end

    context "when merged a string field to null field" do
      let(:initial_schema) { {} }
      let(:other_schema) { { "f" => BqGuess::Fields::String.new("f") } }
      let(:expected_schema) { [{ name: "f", type: :string, mode: :nullable }] }
      it { is_expected.to eq expected_schema }
    end
  end
end
