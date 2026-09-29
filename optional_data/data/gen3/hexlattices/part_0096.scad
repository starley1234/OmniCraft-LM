$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 118.06 x 87.11 mm, 30 cells of 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 118.06;         // panel width
panel_d = 87.11;          // panel depth
thick = 6;                // panel thickness
cell_r = 8;               // hex cell circumradius
pitch = 16.26;            // hex cell pitch (centre to centre)
web = 2.4;                // web between the cells
columns = 6;              // columns of cells
rows = 5;                 // rows of cells
cell_count = 30;          // total cells
shift_x = 14.33;          // first cell offset in x
shift_y = 15.4;           // first cell offset in y
mount_d = 4.4;            // corner mounting holes
hole_off = 3.7;           // mounting hole offset from the corners

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
  translate([3.7, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([114.36, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([3.7, 83.41, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([114.36, 83.41, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
