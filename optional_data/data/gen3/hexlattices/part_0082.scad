$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 104.61 x 77.73 mm, 30 cells of 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 104.61;         // panel width
panel_d = 77.73;          // panel depth
thick = 10;               // panel thickness
cell_r = 7;               // hex cell circumradius
pitch = 14.12;            // hex cell pitch (centre to centre)
web = 2;                  // web between the cells
columns = 6;              // columns of cells
rows = 5;                 // rows of cells
cell_count = 30;          // total cells
shift_x = 13.46;          // first cell offset in x
shift_y = 14.4;           // first cell offset in y
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
  translate([100.91, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([3.7, 74.03, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([100.91, 74.03, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
