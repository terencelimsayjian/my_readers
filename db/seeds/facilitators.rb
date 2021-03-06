require_relative('seed_helper')

facilitator_1 = Facilitator.find_or_create_by(
  email: 'a@b.com',
  full_name: 'Terence Lim Say Jian',
  school: 'SK Puay Chai',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

facilitator_2 = Facilitator.find_or_create_by(
  email: 'facilitator2@email.com',
  full_name: 'Rachel Lim Sze Ying',
  school: 'SK St. Andrews',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

facilitator_3 = Facilitator.find_or_create_by(
  email: 'facilitator3@email.com',
  full_name: 'Daniel Goh Keng Yu',
  school: 'SK Kampung Tunku',
  district: 'Petaling Jaya',
  state: 1,
  phone_number: '0191234123'
) { |facilitator| facilitator.password = 'test1234' }

project_1 = Project.find_or_create_by(
    facilitator_id: facilitator_1.id,
    name: 'SK Puay Chai 2011/2012',
    estimated_start_date: '2016-01-30',
    estimated_end_date: '2017-06-27',
)

student_1_project_1 = Student.find_or_create_by(
    project_id: project_1.id,
    name: 'Ahmad Faizal',
    class_name: '3 Ros',
    phone_number: '0181234567',
)

student_2_project_1 = Student.find_or_create_by(
    project_id: project_1.id,
    name: 'Lee Wan Ling',
    class_name: '2 Dahlia',
    phone_number: '0127654321',
)

student_3_project_1 = Student.find_or_create_by(
    project_id: project_1.id,
    name: 'Muthu Subramanium',
    class_name: '3 Cempedak',
    phone_number: '0158765432',
)

construct_diagnostic(student_1_project_1.id, 1, 3)
construct_diagnostic(student_1_project_1.id, 2, 5)

construct_diagnostic(student_2_project_1.id, 1, 5)
construct_diagnostic(student_2_project_1.id, 2, 8)

construct_diagnostic(student_3_project_1.id, 1, 3)
construct_diagnostic(student_3_project_1.id, 2, 6)
construct_diagnostic(student_3_project_1.id, 3, 11)

project_2 = Project.find_or_create_by(
    facilitator_id: facilitator_2.id,
    name: 'SK Kampung Tunku 2012',
    estimated_start_date: '2016-01-30',
    estimated_end_date: '2017-06-27',
)

student_1_project_2 = Student.find_or_create_by(
    project_id: project_2.id,
    name: 'Darrel Chan',
    class_name: '4 Tembikai',
    phone_number: '0181234567',
)

student_2_project_2 = Student.find_or_create_by(
    project_id: project_2.id,
    name: 'Syed Arriffin',
    class_name: '3 Nenas',
    phone_number: '0127654321',
)

student_3_project_2 = Student.find_or_create_by(
    project_id: project_2.id,
    name: 'Bairavi',
    class_name: '3 Angur',
    phone_number: '0158765432',
)

construct_diagnostic(student_1_project_2.id, 1, 7)
construct_diagnostic(student_1_project_2.id, 2, 10)

construct_diagnostic(student_2_project_2.id, 1, 4)
construct_diagnostic(student_2_project_2.id, 2, 7)
construct_diagnostic(student_2_project_2.id, 2, 8)

construct_diagnostic(student_3_project_2.id, 1, 9)
construct_diagnostic(student_3_project_2.id, 2, 10)
construct_diagnostic(student_3_project_2.id, 3, 11)

