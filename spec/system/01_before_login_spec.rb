require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Joinリンクが表示される: トップに「Join!」の文字がある' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to match(/Join!/)
      end
       it 'Joinリンクの内容が正しい' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_registration_path
      end
    end


  end
end