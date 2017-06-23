/**
 * Custom exception used to debug any information during execution
 *
 * Author: sylvain.picory@methodsdigital.co.uk
 */
public with sharing class Form_CustomException extends Exception {

	public String message {get {return this.getMessage();} set {this.setMessage(value);}}

}