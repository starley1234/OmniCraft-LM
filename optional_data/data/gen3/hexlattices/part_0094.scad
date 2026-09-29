$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 79.89 x 42.57 mm, 18 cells of 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 79.89;          // panel width
panel_d = 42.57;          // panel depth
thick = 5;                // panel thickness
cell_r = 5;               // hex cell circumradius
pitch = 10.26;            // hex cell pitch (centre to centre)
web = 1.6;                // web between the cells
columns = 6;              // columns of cells
rows = 3;                 // rows of cells
cell_count = 18;          // total cells
shift_x = 11.73;          // first cell offset in x
shift_y = 12.4;           // first cell offset in y
mount_d = 4.4;            // corner mounting holes
hole_off = 3.7;           // mounting hole offset from the corners
rim_h = 13;               // rim height
rim_t = 3;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    /* rim around the panel, sunk 1 mm into the plate */
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([3.7, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([76.19, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([3.7, 38.87, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([76.19, 38.87, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
