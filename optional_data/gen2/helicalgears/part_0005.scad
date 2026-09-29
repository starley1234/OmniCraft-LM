$fn = 32;

// ----------------------------------------------------------------------
// Helical gear: m=1.5 z=41, helix 18 deg, 64.5 mm x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
gear_module = 1.5;        // normal module
tooth_count = 41;         // number of teeth
gear_w = 10;              // face width
pa = 20;                  // pressure angle, deg
helix = 18;               // helix angle, deg
twist = 5.85;             // total twist over the face, deg
slices = 4;               // twist divisions
bore = 12;                // shaft bore
hub_dia = 35.8;           // hub diameter
hub_len = 5;              // hub above the face
set_d = 4.5;              // set screw tap hole
set_z = 12.5;             // set screw height

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
  linear_extrude(height = gear_w, twist = twist, slices = slices) tooth_profile();
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
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = hub_dia / 2 + 3, d = set_d);
}
