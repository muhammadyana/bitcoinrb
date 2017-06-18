require 'spec_helper'

describe Bitcoin::Message::NotFound do

  describe 'parse_from_payload' do
    subject{
      Bitcoin::Message::NotFound.parse_from_payload('0101000000cbfb4ac9621ba90f7958cc8f726647105c2ece288eaa9018346639bbad6754ab'.htb)
    }
    it do
      expect(subject.inventory.identifier).to eq(1)
      expect(subject.inventory.hash).to eq('ab5467adbb3966341890aa8e28ce2e5c104766728fcc58790fa91b62c94afbcb')
    end
  end

  describe 'to_pkt' do
    subject {
      Bitcoin::Message::NotFound.new(1, 'ab5467adbb3966341890aa8e28ce2e5c104766728fcc58790fa91b62c94afbcb').to_pkt
    }
    it do
      expect(subject).to eq('0b1109076e6f74666f756e640000000025000000e969f2210101000000cbfb4ac9621ba90f7958cc8f726647105c2ece288eaa9018346639bbad6754ab'.htb)
    end
  end

end
