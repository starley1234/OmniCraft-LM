$fn = 32;
// target_bbox: 180, 30, 30
// connected members with diagonal connections
module strut(a, b, r) {
  hull() {
    translate(a) sphere(r=r);
    translate(b) sphere(r=r);
  }
}
union() {
  strut([2, 2, 2], [178, 2, 2], 2);
  strut([2, 28, 2], [178, 28, 2], 2);
  strut([2, 2, 28], [178, 2, 28], 2);
  strut([2, 28, 28], [178, 28, 28], 2);
  strut([2, 2, 2], [2, 28, 2], 2);
  strut([178, 2, 2], [178, 28, 2], 2);
  strut([2, 2, 28], [2, 28, 28], 2);
  strut([178, 2, 28], [178, 28, 28], 2);
  strut([2, 2, 2], [2, 2, 28], 2);
  strut([178, 2, 2], [178, 2, 28], 2);
  strut([2, 28, 2], [2, 28, 28], 2);
  strut([178, 28, 2], [178, 28, 28], 2);
  strut([2, 2, 2], [178, 28, 28], 2);
  strut([178, 2, 2], [2, 28, 28], 2);
  strut([2, 28, 2], [178, 2, 28], 2);
  strut([178, 28, 2], [2, 2, 28], 2);
  for (x = [2, 178]) translate([x, 2, 0]) cylinder(h=4, r=2);
}
