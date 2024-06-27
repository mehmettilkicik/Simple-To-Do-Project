//Imports

import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor Assistant {
  type ToDo = {
    description : Text;
    completed : Bool;

  };


  func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  //variables
  // var -> mutable
  // let -> immutable

  var todos = Map.HashMap<Nat, ToDo>(0,Nat.equal, natHash);
  var nextId : Nat = 0;

  //functions
  // public - private

  // query -> sorgu methodu
  // update -> güncelleme methodu

  public query func getTodos() : async [ToDo] {
    Iter.toArray(todos.vals());
  };

  public func addTodo(description: Text) : async Nat {

    let id = nextId;
    todos.put(id, {description = description; completed = false});
    nextId += 1;
    id

  };

  public func completeTodo(id : Nat) : async () {

    ignore do ? {
      let description = todos.get(id)!.description;
      todos.put(id, {description; completed = true});
    };

  };


  public query func showTodos() : async Text {

    var output : Text = "\n__TO-DOs__";
    for (todo: ToDo in todos.vals()){
      output #= "\n" # todo.description;
      if (todo.completed) {output #= "!"};
      
    };
    output # "\n"
  };

};