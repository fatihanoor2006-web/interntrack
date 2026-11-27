# InternTrack - Internship Application & Tracking Platform

SEL-311 Software Construction | BSE-5 (Morning) | Bahria University Islamabad (H-11 Campus) | Fall 2026
Instructor: Engr. Saad Mazhar Khan

## Description
InternTrack is a web platform where students search internships, apply online and track the status of every application,
while employers publish vacancies, review applicants and update statuses. Status changes are stored with date, time and
actor and shown to the student as a timeline with in-app notifications.

## Technology
HTML, CSS, JavaScript (front end) | PHP 8.x (back end, three layers) | MySQL 8 / MariaDB | Git and GitHub | Figma (prototype)

## Project status
Assignment 3 (requirements and design): proposal, SRS, SDS and low-fidelity prototype are in the `docs/` folder.
Implementation starts after approval (Assignment 4).

## Documentation
| Document | Location |
|---|---|
| Project proposal | `docs/proposal/024_094_PROJ_PROP.docx` |
| Software Requirements Specification | `docs/srs/SRS_InternTrack.pdf` |
| Software Design Specification | `docs/sds/SDS_InternTrack.pdf` |
| Low-fidelity prototype | `docs/prototype/LowFi_Prototype_InternTrack.pdf` |
| Draft database script | `docs/database/schema.sql` |

## How to run (planned, will be completed with the implementation)
1. Install XAMPP (Apache, PHP 8.x, MySQL) and copy the project into `htdocs/interntrack`.
2. Create the database and tables (see Database setup).
3. Copy `config/config.example.php` to `config/config.php` and enter your database settings.
4. Open `http://localhost/interntrack/public/` in a browser.

## Database setup
Create a database named `interntrack` and import `docs/database/schema.sql` (will move to `database/schema.sql`).

## Members
| Name | Roll No. | Main responsibility |
|---|---|---|
| Fatiha Noor | 024 | Backend foundation, authentication, role permissions, database design, application validation |
| Zara Rizwan | 094 | Frontend layout, responsive pages, dashboards, internship search and tracking interface |

## Screenshots
To be added after implementation.

## Git rules followed
Feature branches merged by pull requests reviewed by the other member; meaningful commit messages; each member commits
with their own account; weekly entries in `PROGRESS_LOG.md`; no passwords or keys in the repository.
