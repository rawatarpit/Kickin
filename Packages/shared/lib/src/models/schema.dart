// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, public_member_api_docs

import 'package:powersync/powersync.dart';

final schema = Schema([
  // Users Table
  Table('users', [
    Column.text('email'),
    Column.text('phone_number'),
    Column.text('otp_code'),
    Column.text('otp_expiry'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: [
    // Unique Indexes for email and phone_number
    Index('email_unique', [IndexedColumn('email')]),
    Index('phone_number_unique', [IndexedColumn('phone_number')]),
  ]),

  // Job Listings Table
  Table('job_listings', [
    Column.text('title'),
    Column.text('description'),
    Column.text('requirements'),
    Column.text('location'),
    Column.text('salary'),
    Column.text('created_at'),
  ], indexes: []),

  // Users Connections Table
  Table('connections', [
    Column.text('user_id'),
    Column.text('connected_user_id'),
    Column.text('connected_at'),
  ], indexes: [
    Index('user_connections',
        [IndexedColumn('user_id'), IndexedColumn('connected_user_id')]),
  ]),

  // Player Profiles Table
  Table('player_profiles', [
    Column.text('user_id'),
    Column.text('name'),
    Column.text('position'),
    Column.text('bio'),
    Column.text('profile_picture_url'),
    Column.text('contact_info'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: [
    Index('user_profile', [IndexedColumn('user_id')]),
  ]),

  // Teams Table
  Table('teams', [
    Column.text('name'),
    Column.text('coach_id'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: []),

  // Coaches Table
  Table('coaches', [
    Column.text('user_id'),
    Column.text('name'),
    Column.text('bio'),
    Column.text('contact_info'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: [
    Index('coach_user', [IndexedColumn('user_id')]),
  ]),

  // Job Applications Table
  Table('job_applications', [
    Column.text('job_listing_id'),
    Column.text('user_id'),
    Column.text('applied_at'),
    Column.text('is_approved'),
  ], indexes: [
    Index('job_application',
        [IndexedColumn('job_listing_id'), IndexedColumn('user_id')]),
  ]),

  // Notifications Table
  Table('notifications', [
    Column.text('user_id'),
    Column.text('message'),
    Column.text('created_at'),
  ], indexes: [
    Index('user_notifications', [IndexedColumn('user_id')]),
  ]),

  // Event Listings Table
  Table('events', [
    Column.text('title'),
    Column.text('description'),
    Column.text('location'),
    Column.text('event_date'),
    Column.text('created_by'),
    Column.text('created_at'),
  ], indexes: []),

  // Scholarships Table
  Table('scholarships', [
    Column.text('title'),
    Column.text('description'),
    Column.text('requirements'),
    Column.text('application_link'),
    Column.text('created_at'),
  ], indexes: []),

  // Job Board Table (for clubs, agents)
  Table('job_board', [
    Column.text('job_listing_id'),
    Column.text('created_by'),
    Column.text('created_at'),
  ], indexes: [
    Index('created_by_index', [IndexedColumn('created_by')]),
  ]),

  // Clubs Table
  Table('clubs', [
    Column.text('name'),
    Column.text('owner_id'),
    Column.text('location'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: []),

  // Agents Table
  Table('agents', [
    Column.text('user_id'),
    Column.text('name'),
    Column.text('agency_name'),
    Column.text('contact_info'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: [
    Index('agent_user', [IndexedColumn('user_id')]),
  ]),
]);
