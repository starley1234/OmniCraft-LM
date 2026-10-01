$fn = 32;

// ----------------------------------------------------------------------
// Vent box: crossgrid enclosure
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 90;               // box length, X
box_w = 80;               // box width, Y
box_h = 45;               // box height, Z
wall_t = 3;               // shell wall thickness
win_l = 60;               // vent window width, X
win_h = 32;               // vent window height, Z
bar_w = 4;                // grid bar width
n_v = 4;                  // vertical bar count
n_h = 3;                  // horizontal bar count

win_z0 = (box_h - win_h) / 2;  // window lower edge Z
v_step = win_l / (n_v + 1);  // vertical bar step
h_step = win_h / (n_h + 1);  // horizontal bar step

difference() {
  union() {
    difference() {
      cube([box_l, box_w, box_h]);
  translate([wall_t, wall_t, wall_t])
    cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);
  translate([(box_l - win_l) / 2, box_w - wall_t - 1, win_z0])
    cube([win_l, wall_t + 2, win_h]);
    }
    for (i = [1 : n_v])
      translate([(box_l - win_l) / 2 + i * v_step - bar_w / 2,
                 box_w - wall_t - 1, win_z0 - 1])
        cube([bar_w, wall_t + 1, win_h + 2]);
    for (i = [1 : n_h])
      translate([(box_l - win_l) / 2 - 1, box_w - wall_t - 1,
                 win_z0 + i * h_step - bar_w / 2])
        cube([win_l + 2, wall_t + 1, bar_w]);
  }
}
