$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 60;             // mounting hole offset
rim_h = 10;               // rim height
rim_t = 3;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 91 */
  hull() {
    translate([29.5, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([120.5, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 97.5 */
  hull() {
    translate([26.25, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([123.75, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.6, length 104 */
  hull() {
    translate([23, 34.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([127, 34.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 110.5 */
  hull() {
    translate([19.75, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.25, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 15, d = mount_d);
  translate([15, 65, -2.5]) cylinder(h = 15, d = mount_d);
  translate([135, 5, -2.5]) cylinder(h = 15, d = mount_d);
  translate([135, 65, -2.5]) cylinder(h = 15, d = mount_d);
}
