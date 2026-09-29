$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=1 z=47, 49 mm tip diameter x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
gear_module = 1;          // module
tooth_count = 47;         // number of teeth
gear_w = 8;               // face width
pa = 20;                  // pressure angle, deg
bore = 14;                // shaft bore
key_w = 5;                // keyway width
key_h = 2.3;              // keyway depth
set_d = 4.5;              // set screw tap hole
set_z = 9;                // set screw height

/* --- involute profile --- */
pitch_r = gear_module * tooth_count / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + gear_module;
root_r = pitch_r - 1.25 * gear_module;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / tooth_count + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / tooth_count + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : tooth_count - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / tooth_count)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = gear_w) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = gear_w + 3, d = bore);
  /* keyway on the bore */
  translate([-bore / 2 - 1, -key_w / 2, -1]) cube([key_h + 1, key_w, gear_w + 3]);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = (root_r * 0.6), d = set_d);
}
