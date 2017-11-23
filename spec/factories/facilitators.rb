FactoryGirl.define do
  factory :facilitator do
    email { Faker::Internet.unique.email }
    password 'test1234'
    full_name 'John Doe'
    school 'SMK Merbok'
    district 'Merbok'
    state 'Kedah'
    phone_number '0193131379'

    # reset_password_token 'somestring'
    # reset_password_sent_at Date.now
    # remember_created_at Date.now
    # sign_in_count 5
    # current_sign_in_at Date.now
    # last_sign_in_at Date.now
    # current_sign_in_ip
    # last_sign_in_ip
    # invitation_token
    # invitation_created_at
    # invitation_sent_at
    # invitation_accepted_at
    # invitation_limit
    # invited_by_id
    # invited_by_type
  end
end
