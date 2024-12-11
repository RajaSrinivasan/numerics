with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Numerics.Elementary_Functions;
with Ada.Containers;
with GNAT.Source_Info; use GNAT.Source_Info;
with numlibfloat;      use numlibfloat;

procedure Stats is

   use type Ada.Containers.Count_Type;
   verbose : Boolean         := True;
   myname  : constant String := Enclosing_Entity;
   procedure show (nm : String; v : lib.RealVectors_Pkg.Vector) is
      use lib.RealVectors_Pkg;
   begin
      Put ("Vector ");
      Put_Line (nm);
      Put ("Length ");
      Put_Line (v.Length'Image);
      Put ("Mean ");
      Put_Line (statspkg.mean (v)'Image);
      Put ("Stdev ");
      Put_Line (statspkg.stdev (v)'Image);
      Put_Line ("Values ");
      lib.Print (v);
      New_Line;
   end show;

   procedure basics is
      use lib.RealVectors_Pkg;
      unit       : constant String := Enclosing_Entity;
      v1, v2, v3 : Vector;
      vcor       : Float;

   begin
      if verbose then
         Put_Line (unit);
      end if;
      v1 := lib.Create (16, 1.0);
      v2 := lib.Create (v1);
      v3 := lib.Create (16, 0.0, 1.0);

      lib.Mult (v2, 3.0);

      vcor := statspkg.cor (v1, v2);
      Put_Line ("Correlation Coefficient ");
      Put (vcor'Image);
      New_Line;
      lib.Mutate (V3, Ada.numerics.elementary_functions.sqrt'Access);
      show ("V3", v3);
      --vcor := statspkg.cor( v3 , v2 );
      --Put("Correlation "); Put( vcor'Image); New_Line ;
      vcor := statspkg.cor (v3, v3);
      Put ("Self Correlation ");
      Put (vcor'Image);
      New_Line;
   end basics;

   -- codemd: begin segment=Random caption=Random Variates
   procedure random is
      use lib.RealVectors_Pkg;
      unit : constant String := Enclosing_Entity;
      rv   : Vector;
   begin
      if verbose then
         Put_Line (unit);
      end if;
      if Argument_Count > 1 then
         rv := statspkg.Normal (100, 10.0, 5.0);
         Put_Line ("Normal ");
      else
         rv := statspkg.Uniform (100);
         Put_Line ("Uniform ");
      end if;
      show (" ", rv);
   end random;
   -- codemd: end

   procedure copy is
      use lib.RealVectors_Pkg;
      unit     : constant String := Enclosing_Entity;
      rv1, rv2 : Vector;
      rv3      : Vector;
   begin
      if verbose then
         Put_Line (unit);
      end if;

      rv1 := statspkg.Normal (37, 10.0, 5.0);
      Put_Line ("Normal rv1");
      show ("rv1", rv1);
      New_Line;

      rv2 := statspkg.Uniform (63);
      Put_Line ("Uniform");
      show ("rv2", rv2);
      New_Line;

      rv3 := lib.Append (rv1, rv2);
      Put_Line ("rv3=rv2 appended to v1");
      show ("rv3  ", rv3);
      New_Line;

      append (rv2, rv1);
      Put_Line ("rv2 - in place append");
      show ("rv2", rv2);
      New_Line;

   end copy;

begin
   if Argument_Count < 1 then
      Put_Line ("usage: stats [b|c|r]");
   elsif Argument (1) = "b" then
      basics;
   elsif Argument (1) = "c" then
      copy;
   elsif Argument (1) = "r" then
      random;
   end if;
end Stats;
