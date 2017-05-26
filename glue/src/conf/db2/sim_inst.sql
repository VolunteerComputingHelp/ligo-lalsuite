-- This file is part of the Grid LSC User Environment (GLUE)
-- 
-- GLUE is free software: you can redistribute it and/or modify it under the
-- terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- details.
-- 
-- You should have received a copy of the GNU General Public License along
-- with this program.  If not, see <http://www.gnu.org/licenses/>.

CREATE TABLE sim_inst
(
-- The table describes particular representative of simulation types from sim_type table with such parameters
-- as signal duration, start time, source sky position chosen (usually randomly).

-- Simulation instance id (automatically generated by DB2, unique)
      simulation_id              CHAR(13) FOR BIT DATA NOT NULL,
-- LIGO/LSC site that created this entry
      creator_db         INTEGER NOT NULL WITH DEFAULT 1,
-- Process which generated this entry
      process_id         CHAR(13) FOR BIT DATA NOT NULL, 
-- Simulation type from sim_type table
      sim_type               INTEGER NOT NULL, 
-- How many bursts were injected in the simulation for the given time interval
      s_burst_count      INTEGER,
      
-- Insertion time (automatically assigned by the database)
      insertion_time     TIMESTAMP WITH DEFAULT CURRENT TIMESTAMP,

      CONSTRAINT sim_in_pk
      PRIMARY KEY (simulation_id, creator_db),

      CONSTRAINT sim_in_fk_st
      FOREIGN KEY (sim_type)
          REFERENCES sim_type(sim_type)
          ON DELETE CASCADE,

      CONSTRAINT sim_fk_pid
      FOREIGN KEY (process_id, creator_db)
          REFERENCES process(process_id, creator_db)

)   
-- The following line is needed for this table to be replicated to other sites
DATA CAPTURE CHANGES
;
