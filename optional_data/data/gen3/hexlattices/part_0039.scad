$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 134.85 x 79.73 mm, 40 cells of 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 134.85;         // panel width
panel_d = 79.73;          // panel depth
thick = 6;                // panel thickness
cell_r = 7;               // hex cell circumradius
pitch = 14.12;            // hex cell pitch (centre to centre)
web = 2;                  // web between the cells
columns = 8;              // columns of cells
rows = 5;                 // rows of cells
cell_count = 40;          // total cells
shift_x = 14.46;          // first cell offset in x
shift_y = 15.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([4.2, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([130.65, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 75.53, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([130.65, 75.53, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
