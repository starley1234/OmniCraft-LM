$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=2.5 z=12, 35 mm tip diameter x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
modul = 2.5;              // module
n_teeth = 12;             // number of teeth
width = 16;               // face width
pa = 20;                  // pressure angle, deg
shaft_d = 8.31;           // shaft bore
key_w = 3;                // keyway width
key_h = 1.4;              // keyway depth
set_d = 3.4;              // set screw tap hole
set_z = 17;               // set screw height

/* --- involute profile --- */
pitch_r = modul * n_teeth / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + modul;
root_r = pitch_r - 1.25 * modul;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / n_teeth + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / n_teeth + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : n_teeth - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / n_teeth)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = width) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = width + 3, d = shaft_d);
  /* keyway on the bore */
  translate([-shaft_d / 2 - 1, -key_w / 2, -1]) cube([key_h + 1, key_w, width + 3]);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = (root_r * 0.6), d = set_d);
}
