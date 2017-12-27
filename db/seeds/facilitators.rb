Facilitator.find_or_create_by(
  email: 'a@b.com',
  full_name: 'Terence Lim Say Jian',
  school: 'SK Puay Chai',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

Facilitator.find_or_create_by(
  email: 'facilitator2@email.com',
  full_name: 'Rachel Lim Sze Ying',
  school: 'SK St. Andrews',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

Facilitator.find_or_create_by(
  email: 'facilitator3@email.com',
  full_name: 'Daniel Goh Keng Yu',
  school: 'SK Kampung Tunku',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

Facilitator.find_or_create_by(
  email: 'facilitator4@email.com',
  full_name: 'Charis Ding',
  school: 'SK Taman Mydin',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

Facilitator.find_or_create_by(
  email: 'facilitator5@email.com',
  full_name: 'Nurul Fatimah',
  school: 'SK Taman Megah',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

