require 'rails_helper'

RSpec.describe 'time_sheets/new', type: :view do
  before(:each) do
    @time_sheet = assign(:time_sheet, FactoryGirl.create(:time_sheet))
    login_as @time_sheet.contract.hiwi
  end

  it 'renders the edit time_sheet form' do
    render

    assert_select 'form[action=?][method=?]', contract_time_sheet_path(@time_sheet.contract, @time_sheet), 'post' do

    end
  end

  it 'does not display the work day table' do
  	render

  	expect(page.html).not_to have_content('<table>');
  end
end
