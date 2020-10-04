require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        expect(post.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        expect(post.valid?).to eq false;
      end
    end
    context 'stepsカラム' do
      it '空欄でないこと' do
        post.steps = ''
        expect(post.valid?).to eq false;
      end
      it '数字以外で入力されていないこと' do
        post.steps = Faker::Lorem.characters
        expect(post.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
