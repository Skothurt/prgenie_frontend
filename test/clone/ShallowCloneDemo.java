package clone;

public class ShallowCloneDemo {

	public static void main(String[] args) throws CloneNotSupportedException {
		Employee e1 = new Employee(1,"sundeep");
		Employee e2 = e1.clone();
		 System.out.println("e1 == e2 ? " + (e1 == e2));
	        System.out.println("e1.equals(e2) ? " + (e1.equals(e2)));
	        System.out.println("e1.name == e2.name ? " + (e1.name == e2.name));

	}

}
class Employee implements Cloneable{
	int id;
	String name;
	
	Employee(int id, String name){
		this.id = id;
		this.name= name;
		
	}
 protected Employee clone()  throws CloneNotSupportedException{
	return (Employee) super.clone();
}
}