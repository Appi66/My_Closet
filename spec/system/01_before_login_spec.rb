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

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

     context '表示内容の確認' do
      it 'MyClosetリンクの内容が正しい' do
        home_link = find_all('a')[0].native.inner_text
        expect(page).to have_link home_link, href: root_path
      end
      it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/About/)
      end
      it 'SignUpリンクが表示される: 左上から3番目のリンクが「SignUp」である' do
        signup_link = find_all('a')[2].native.inner_text
        expect(signup_link).to match(/SignUp/)
      end
      it 'Loginリンクが表示される: 左上から4番目のリンクが「LogIn」である' do
        login_link = find_all('a')[3].native.inner_text
        expect(login_link).to match(/LogIn/)
      end
     end

     context 'リンクの内容を確認' do
      subject { current_path }

      it 'Aboutを押すと、About画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.delete(' ')
        about_link.gsub!(/\n/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'SignUpを押すと、SignUp画面に遷移する' do
        signup_link = find_all('a')[2].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'LogInを押すと、LogInに遷移する' do
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end
    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、投稿一覧画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/post_images'
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「Log in」と表示される' do
        expect(page).to have_content 'Log in'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
      it 'emailフォームは表示されない' do
        expect(page).not_to have_field 'user[email]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/post_images'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      it 'Postリンクが表示される: 左上から2番目のリンクが「Post」である' do
        post_link = find_all('a')[1].native.inner_text
        expect(post_link).to match(/Post/)
      end
      it 'MyPageリンクが表示される: 左上から3番目のリンクが「MyPage」である' do
        mypage_link = find_all('a')[2].native.inner_text
        expect(mypage_link).to match(/MyPage/)
      end
      it 'MyClosetリンクが表示される: 左上から4番目のリンクが「MyCloset」である' do
        mycloset_link = find_all('a')[3].native.inner_text
        expect(mycloset_link).to match(/MyCloset/)
      end
      it 'Noticeリンクが表示される: 左上から5番目のリンクが「Notice」である' do
        notice_link = find_all('a')[4].native.inner_text
        expect(notice_link).to match(/Notice/)
      end
      it 'LogOutリンクが表示される: 左上から6番目のリンクが「LogOut」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match(/LogOut/)
      end
    end
  end


  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[5].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end

end
