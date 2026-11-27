-- InternTrack draft schema (from SDS section 4). MySQL 8 / MariaDB, InnoDB.
CREATE DATABASE IF NOT EXISTS interntrack CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE interntrack;

CREATE TABLE Users (
  user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('student','employer') NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE StudentProfiles (
  profile_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL UNIQUE,
  university VARCHAR(120), degree_program VARCHAR(100), phone VARCHAR(20), bio VARCHAR(300),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Companies (
  company_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL UNIQUE,
  company_name VARCHAR(120) NOT NULL,
  description TEXT, website VARCHAR(200), location VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Internships (
  internship_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  company_id INT UNSIGNED NOT NULL,
  title VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  requirements TEXT,
  location VARCHAR(100) NOT NULL,
  deadline DATETIME NOT NULL,
  status ENUM('draft','published','closed') NOT NULL DEFAULT 'draft',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (company_id) REFERENCES Companies(company_id) ON DELETE CASCADE,
  INDEX idx_search (status, deadline)
) ENGINE=InnoDB;

CREATE TABLE Applications (
  application_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  internship_id INT UNSIGNED NOT NULL,
  cover_note VARCHAR(500),
  current_status ENUM('Submitted','Under Review','Shortlisted','Rejected','Selected') NOT NULL DEFAULT 'Submitted',
  applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (internship_id) REFERENCES Internships(internship_id) ON DELETE CASCADE,
  UNIQUE KEY uq_student_internship (student_id, internship_id)
) ENGINE=InnoDB;

CREATE TABLE ApplicationStatusHistory (
  history_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  application_id INT UNSIGNED NOT NULL,
  old_status ENUM('Submitted','Under Review','Shortlisted','Rejected','Selected') NULL,
  new_status ENUM('Submitted','Under Review','Shortlisted','Rejected','Selected') NOT NULL,
  changed_by INT UNSIGNED NOT NULL,
  changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  note VARCHAR(255) NULL,
  FOREIGN KEY (application_id) REFERENCES Applications(application_id) ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES Users(user_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Skills (
  skill_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  skill_name VARCHAR(40) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  UNIQUE KEY uq_student_skill (student_id, skill_name)
) ENGINE=InnoDB;

CREATE TABLE Notifications (
  notification_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  application_id INT UNSIGNED NULL,
  message VARCHAR(255) NOT NULL,
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (application_id) REFERENCES Applications(application_id) ON DELETE CASCADE,
  INDEX idx_unread (user_id, is_read)
) ENGINE=InnoDB;
