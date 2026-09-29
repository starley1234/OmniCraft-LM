$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=3 z=47, 147 mm tip diameter x 19 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
gear_module = 3;          // module
tooth_count = 47;         // number of teeth
gear_w = 15;              // face width
pa = 20;                  // pressure angle, deg
bore = 8;                 // shaft bore
hub_dia = 93.4;           // hub diameter
hub_len = 4;              // hub above the face
light_d = 12;             // lightening hole diameter
light_r = 56.7;           // lightening hole pitch radius
set_d = 3.4;              // set screw tap hole
set_z = 17;               // set screw height

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

module hub_boss() {
  translate([0, 0, gear_w - 1]) cylinder(h = hub_len + 1, d = hub_dia);
}

difference() {
  union() {
    gear_disc();
    hub_boss();
  }
  translate([0, 0, -1]) cylinder(h = gear_w + hub_len + 3, d = bore);
  /* lightening holes in the web */
  for (i = [0 : 4 - 1]) rotate([0, 0, i * 360 / 4]) translate([light_r, 0, -1])
    cylinder(h = gear_w + 3, d = light_d);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = hub_dia / 2 + 3, d = set_d);
}
