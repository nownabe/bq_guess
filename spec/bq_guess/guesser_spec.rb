# frozen_string_literal: true

require "bq_guess/guesser"

describe BqGuess::Guesser do
  let(:instance) { described_class.new(record) }

  describe "#guess" do
    subject { instance.guess.to_a }

    context "when given a true field" do
      let(:record) { { "f" => true } }
      let(:expected_schema) { [{ name: "f", type: :boolean, mode: :required }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a false field" do
      let(:record) { { "f" => false } }
      let(:expected_schema) { [{ name: "f", type: :boolean, mode: :required }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a float field" do
      let(:record) { { "f" => 1.0 } }
      let(:expected_schema) { [{ name: "f", type: :float, mode: :required }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a integer field" do
      let(:record) { { "f" => 1 } }
      let(:expected_schema) { [{ name: "f", type: :integer, mode: :required }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a null field" do
      let(:record) { { "f" => nil } }
      let(:expected_schema) { [{ name: "f", type: :string, mode: :nullable }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a record field" do
      let(:record) { { "f" => { "nested" => true } } }
      let(:expected_schema) do
        [
          {
            name: "f",
            type: :record,
            mode: :required,
            fields: [{ name: "nested", type: :boolean, mode: :required }]
          }
        ]
      end
      it { is_expected.to eq expected_schema }
    end

    context "when given a string field" do
      let(:record) { { "f" => "string" } }
      let(:expected_schema) { [{ name: "f", type: :string, mode: :required }] }
      it { is_expected.to eq expected_schema }
    end

    context "when given a repeated field" do
      let(:record) { { "f" => [1, 2, 3] } }
      let(:expected_schema) { [{ name: "f", type: :integer, mode: :repeated }] }
      it { is_expected.to eq expected_schema }
    end
  end
end
