
DROP FUNCTION IF EXISTS new_user(_name character varying, _tags character VARYING, _password CHARACTER VARYING, _group INTEGER);
DROP FUNCTION IF EXISTS new_project(_descr character varying, _project_name character VARYING, _lnsession_id INTEGER);
DROP FUNCTION IF exists new_plate_set(_descr VARCHAR(30), _plate_set_name VARCHAR(30), _num_plates INTEGER, _plate_format_id INTEGER,  _plate_type_id INTEGER, _project_id INTEGER, _plate_layout_name_id INTEGER, _lnsession_id INTEGER,  _with_samples boolean, _target_layout_name_id INTEGER);

DROP FUNCTION IF exists new_plate_set_from_group(_descr VARCHAR(30), _plate_set_name VARCHAR(30), _num_plates INTEGER, _plate_format_id INTEGER,  _plate_type_id INTEGER, _project_id INTEGER, _plate_layout_name_id INTEGER, _lnsession_id INTEGER);
DROP FUNCTION IF exists get_num_samples_for_plate_set( _plate_set_id INTEGER);
DROP FUNCTION IF exists assoc_plate_ids_with_plate_set_id( _plate_ids INTEGER[], _plate_set_id INTEGER);
DROP FUNCTION IF EXISTS new_plate(INTEGER, INTEGER,INTEGER,INTEGER, BOOLEAN);
DROP FUNCTION IF EXISTS new_sample(INTEGER,INTEGER,INTEGER);

DROP FUNCTION IF EXISTS new_target(INTEGER,VARCHAR,VARCHAR,VARCHAR);
DROP FUNCTION IF EXISTS new_target_layout_name(INTEGER,VARCHAR,VARCHAR,INTEGER,INTEGER,INTEGER,INTEGER,INTEGER);
DROP FUNCTION IF EXISTS bulk_target_upload( _fields text[]);
DROP FUNCTION IF EXISTS new_assay_run(  VARCHAR(30), VARCHAR(30), INTEGER,  INTEGER, INTEGER);
DROP FUNCTION IF EXISTS get_ids_for_sys_names( VARCHAR[], VARCHAR(30), VARCHAR(30));
DROP FUNCTION IF EXISTS get_number_samples_for_psid( _psid INTEGER );
DROP FUNCTION IF EXISTS new_plate_layout(  VARCHAR(30), VARCHAR(30), INTEGER,  VARCHAR[][]);
DROP FUNCTION IF exists reformat_plate_set(source_plate_set_id INTEGER, source_num_plates INTEGER, n_reps_source INTEGER, dest_descr VARCHAR(30), dest_plate_set_name VARCHAR(30), dest_num_plates INTEGER, dest_plate_format_id INTEGER, dest_plate_type_id INTEGER, project_id INTEGER, dest_plate_layout_name_id INTEGER, lnsession_id INTEGER, target_layout_name_id INTEGER );
DROP FUNCTION IF exists process_assay_run_data(_assay_run_id integer);

DROP FUNCTION IF exists get_scatter_plot_data( integer);
DROP FUNCTION IF EXISTS new_hit_list(_name VARCHAR(250), _descr VARCHAR(250), _num_hits INTEGER, _assay_run_id INTEGER, _lnsession_id INTEGER, hit_list integer[]);

DROP FUNCTION IF EXISTS process_access_ids( INTEGER, VARCHAR);
DROP FUNCTION IF EXISTS create_layout_records(VARCHAR, VARCHAR, VARCHAR, INTEGER, INTEGER, INTEGER, integer );
DROP FUNCTION IF EXISTS get_all_data_for_assay_run(_assay_run_ids INTEGER );
DROP FUNCTION IF EXISTS rearray_transfer_samples(integer, INTEGER, integer);
DROP FUNCTION IF EXISTS global_search(_term character varying);
DROP FUNCTION IF EXISTS delete_neg_response() CASCADE;
DROP FUNCTION IF EXISTS get_all_sessions() CASCADE;

DROP TRIGGER IF EXISTS delete_neg_value ON assay_result_pre;

DROP TABLE IF EXISTS lnuser_groups CASCADE;
DROP TABLE IF EXISTS sess_person CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP SEQUENCE IF EXISTS  sessions_id_seq CASCADE;
DROP INDEX IF EXISTS sessions_pkey CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP SEQUENCE IF EXISTS  project_id_seq CASCADE;
DROP INDEX IF EXISTS project_pkey CASCADE;
DROP TABLE IF EXISTS plate_format CASCADE;
DROP TABLE IF EXISTS plate_type CASCADE;
DROP TABLE IF EXISTS plate_layout_name CASCADE;
DROP TABLE IF EXISTS layout_source_dest CASCADE;
DROP TABLE IF EXISTS target CASCADE;
DROP SEQUENCE IF EXISTS target_id_seq;
DROP TABLE IF EXISTS target_layout_name CASCADE;
DROP SEQUENCE IF EXISTS target_layout_name_id_seq;
DROP TABLE IF EXISTS target_layout CASCADE;
DROP TABLE IF EXISTS plate_set CASCADE;
DROP TABLE IF EXISTS plate_plate_set CASCADE;
DROP SEQUENCE IF EXISTS plate_set_id_seq;
DROP TABLE IF EXISTS plate CASCADE;
DROP TABLE IF EXISTS well CASCADE;
DROP TABLE IF EXISTS sample CASCADE;
DROP TABLE IF EXISTS well CASCADE;
DROP TABLE IF EXISTS well_sample CASCADE;
DROP TABLE IF EXISTS assay_type CASCADE;
DROP TABLE IF EXISTS assay_run CASCADE;
DROP TABLE IF EXISTS assay_result CASCADE;
DROP TABLE IF EXISTS assay_result_pre CASCADE;
DROP TABLE IF EXISTS hit_list CASCADE;
DROP TABLE IF EXISTS hit_sample CASCADE;
DROP TABLE IF EXISTS well_type CASCADE;

DROP TABLE IF EXISTS plate_layout CASCADE;
DROP TABLE IF EXISTS import_plate_layout CASCADE;
DROP TABLE IF EXISTS temp_accs_id CASCADE;
DROP TABLE IF EXISTS rearray_pairs CASCADE;
DROP TABLE IF EXISTS worklists CASCADE;
DROP TABLE IF EXISTS well_numbers CASCADE;

DROP TABLE IF EXISTS assay_run_stats CASCADE;
DROP TABLE IF EXISTS temp_barcode_id CASCADE;
