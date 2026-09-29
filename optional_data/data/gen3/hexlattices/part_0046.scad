$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 118.13 x 59 mm, 32 cells of 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 118.13;         // panel width
panel_d = 59;             // panel depth
thick = 6;                // panel thickness
cell_r = 6;               // hex cell circumradius
pitch = 12.39;            // hex cell pitch (centre to centre)
web = 2;                  // web between the cells
columns = 8;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 32;          // total cells
shift_x = 12.6;           // first cell offset in x
shift_y = 13.4;           // first cell offset in y
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
  translate([114.43, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([3.7, 55.3, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([114.43, 55.3, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
